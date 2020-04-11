describe('The board feature', () => {
  let token = ''
  beforeEach(function () {
    cy.prepare()
    cy.log('Fetching web service token')
    cy.request({
      url: `/services/api/rest/json/?method=auth.gettoken&username=${Cypress.env('admin_username')}&password=${Cypress.env(
        'admin_password')}`,
      method: 'POST'
    })
      .then(
        resp => {
          expect(resp.body.status).to.eq(0)
          token = resp.body.result
          cy.clearNotifications(token)
          cy.login()
          cy.log('Adding test discussion')
          cy.request({
            method: 'POST',
            form: true,
            body: this.testdata.board.add,
            url: '/action/discussion/save'
          })
        }
      )
  })

  it('should send a notification to everybody when creating a discussion', function () {
    cy.log('Triggering notifications')
    cy.request({
      url: `/services/api/rest/json/?method=filetransport.notifications.send&auth_token=${token}`,
      method: 'POST'
    })
      .then(
        resp => {
          expect(resp.body.status).to.eq(0)
        }
      )
    cy.request({
      url: `/services/api/rest/json/?method=filetransport.notifications.get&auth_token=${token}`,
      method: 'GET'
    })
      .then(
        resp => {
          expect(resp.body.status).to.eq(0)
          expect(resp.body.result).to.have.length.of.at.least(this.counts.board.minNotifications)
          let foundMyself = false
          let foundOtherTestuser = false
          for (const notification of resp.body.result) {
            if (notification[ 'to' ].includes(this.testdata.users[ 0 ].email)) {
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
    'liked': testdata => {
      cy.login(testdata.users[ 1 ].username, testdata.users[ 1 ].password)
      cy.visit(`/discussion/group/${testdata.board.boardId}`)
      cy.contains(testdata.board.add.title).click()
      cy.get('[data-menu-item=likes]:first').click()
      cy.clearNotifications(token)
    },
    'commented': testdata => {
      cy.login(testdata.users[ 1 ].username, testdata.users[ 1 ].password)
      cy.visit(`/discussion/group/${testdata.board.boardId}`)
      cy.contains(testdata.board.add.title).click()
      cy.typeCkEditor(testdata.board.comments.add)
      cy.get('.elgg-form-comment-save .elgg-button-submit').click()
      cy.get('.elgg-spinner').should('not.be.visible')
      cy.clearNotifications(token)
    },
    'subscribed': testdata => {
      cy.login(testdata.users[ 1 ].username, testdata.users[ 1 ].password)
      cy.visit(`/discussion/group/${testdata.board.boardId}`)
      cy.contains(testdata.board.add.title).click()
      cy.get('[data-menu-item=entity-menu-toggle]').click()
      cy.get('[data-menu-item=content_subscription_subscribe').click()
    }
  }

  for (const method in subscribingMethods) {
    if (subscribingMethods.hasOwnProperty(method)) {
      it(`should send a notification to everybody when creating a discussion, but only to people who ${method} the post on commenting`,
        function () {
          cy.clearNotifications(token)

          subscribingMethods[ method ](this.testdata)

          cy.login()
          cy.visit(`/discussion/group/${this.testdata.board.boardId}`)
          cy.contains(this.testdata.board.add.title).click()

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
                  url: `/services/api/rest/json/?method=filetransport.notifications.send&auth_token=${token}`,
                  method: 'POST'
                })
                cy.request({
                  url: `/services/api/rest/json/?method=filetransport.notifications.get&auth_token=${token}`,
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
