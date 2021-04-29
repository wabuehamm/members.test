describe('The board feature', function () {
  beforeEach(function () {
      cy.clearNotifications(this.token)
      cy.login()
      cy.log('Adding test discussion')
      cy.request({
        method: 'POST',
        url: `/services/api/rest/json/?method=wabue.discussion.add&auth_token=${this.token}&discussion=${encodeURIComponent(
          JSON.stringify(this.testdata.board.add))}`
      })
    }
  )

  it('should send a notification to everybody when creating a discussion', function () {
    cy.log('Triggering notifications')
    cy.request({
      url: `/services/api/rest/json/?method=filetransport.notifications.send&auth_token=${this.token}`,
      method: 'POST'
    })
      .then(
        resp => {
          expect(resp.body.status).to.eq(0)
        }
      )
    cy.request({
      url: `/services/api/rest/json/?method=filetransport.notifications.get&auth_token=${this.token}`,
      method: 'GET'
    })
      .then(
        resp => {
          expect(resp.body.status).to.eq(0)
          expect(resp.body.result).to.have.length.of.at.least(this.counts.board.minNotifications)
          let foundMyself = false
          let foundOtherTestuser = false
          for (const notification of resp.body.result) {
            // The user used for the notification is the admin user and not the created owner
            // because of this https://github.com/Elgg/Elgg/issues/13185
            if (notification[ 'to' ].includes(Cypress.env('admin_username'))) {
              foundMyself = true
            }
            if (notification[ 'to' ].includes(this.testdata.users[ 1 ].email)) {
              foundOtherTestuser = true
            }
          }
          expect(foundMyself).to.not.be.true
          expect(foundOtherTestuser).to.be.true
        }
      )
  })

  const subscribingMethods = {
    'liked': (testdata: any, token: string) => {
      cy.login(testdata.users[ 1 ].username, testdata.users[ 1 ].password)
      cy.visit(`/discussion/group/${testdata.board.boardId}`)
      cy.contains(testdata.board.add.title).click()
      cy.get('iframe')
      cy.get('[data-menu-item=likes]:first > a').click()
      cy.get('.elgg-spinner').should('not.be.visible')
      cy.clearNotifications(token)
    },
    'commented': (testdata: any, token: string) => {
      cy.login(testdata.users[ 1 ].username, testdata.users[ 1 ].password)
      cy.visit(`/discussion/group/${testdata.board.boardId}`)
      cy.contains(testdata.board.add.title).click()
      cy.typeCkEditor(testdata.board.comments.add)
      cy.get('.elgg-form-comment-save .elgg-button-submit').click()
      cy.get('.elgg-spinner').should('not.be.visible')
      cy.clearNotifications(token)
    },
    'subscribed': (testdata: any, token: string) => {
      cy.login(testdata.users[ 1 ].username, testdata.users[ 1 ].password)
      cy.visit(`/discussion/group/${testdata.board.boardId}`)
      cy.contains(testdata.board.add.title).click()
      cy.get('iframe')
      cy.get('[data-menu-item=entity-menu-toggle] > a').click()
      cy.get('[data-menu-item=content_subscription_subscribe').click()
    }
  }

  for (const method in subscribingMethods) {
    if (subscribingMethods.hasOwnProperty(method)) {
      it(`should send a notification to everybody when creating a discussion, but only to people who ${method} the post on commenting`,
        function () {
          cy.clearNotifications(this.token)

          ;(
            subscribingMethods as any
          )[ method ](this.testdata, this.token)

          cy.login()
          cy.visit(`/discussion/group/${this.testdata.board.boardId}`)
          cy.contains(this.testdata.board.add.title).click()

          cy.get('iframe')
          cy.get('body')
            .then(
              elem => {
                if (elem.find('[data-menu-item=add]').length > 0) {
                  cy.get('[data-menu-item=add]').click()
                }
              }
            )
            .then(
              () => {
                cy.typeCkEditor(this.testdata.board.comments.add)
                cy.get('.elgg-form-comment-save .elgg-button-submit').click()
                cy.get('.elgg-spinner').should('not.be.visible')
                cy.log('Triggering notifications')
                cy.request({
                  url: `/services/api/rest/json/?method=filetransport.notifications.send&auth_token=${this.token}`,
                  method: 'POST'
                })
                cy.request({
                  url: `/services/api/rest/json/?method=filetransport.notifications.get&auth_token=${this.token}`,
                  method: 'GET'
                })
                  .then(
                    resp => {
                      expect(resp.body.status).to.eq(0)
                      expect(resp.body.result).to.have.length.of.at.most(this.counts.board.maxSubscriberNotifications)
                      let foundTestUser = false
                      for (const notification of resp.body.result) {
                        if (notification.to.includes(this.testdata.users[ 1 ].email)) {
                          foundTestUser = true
                        }
                      }
                      expect(foundTestUser).to.be.true
                    }
                  )
              }
            )
        })
    }
  }

})
