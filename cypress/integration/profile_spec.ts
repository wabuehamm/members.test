describe('The user profile feature', function () {
  beforeEach(() => {
    cy.fixCypressSpec('/cypress/integration/profile_spec.ts')
    cy.login()
  })
  it('should show all data to the owner', function () {
    cy.visit('/profile')
    for (const key in this.testdata.users[ 0 ]) {
      if (this.testdata.users[ 0 ].hasOwnProperty(key)) {
        if (this.testdata.profile.allFields.indexOf(key) === 0) {
          cy.contains(this.testdata.users[ 0 ][ key ])
        }
      }
    }
  })
  it('should show only some data to everybody else', function () {
    cy.visit(`/profile/${this.testdata.users[ 1 ].username}`)
    for (const key in this.testdata.users[ 1 ]) {
      if (this.testdata.users[ 1 ].hasOwnProperty(key)) {
        if (this.testdata.profile.allFields.indexOf(key) === 0) {
          if (this.testdata.profile.hiddenFields.indexOf(key) === 0) {
            cy.contains(this.testdata.users[ 1 ][ key ]).should('not.exist')
          } else {
            cy.contains(this.testdata.users[ 1 ][ key ])
          }
        }
      }
    }
  })
  it('should allow editing of fields', function () {
    cy.visit('/profile')
    cy.get('[data-menu-item=edit_profile]').click()
    cy.document().toMatchImageSnapshot({
      name: `profile.${Cypress.env('viewtype')}`
    })
    for (const key in this.testdata.profile.editedProfile) {
      if (this.testdata.profile.editedProfile.hasOwnProperty(key)) {
        cy.get(`[name="${key}"]`).clear().type(this.testdata.profile.editedProfile[key])
      }
    }
    cy.get('.elgg-form-profile-edit').submit()
    cy.visit('/profile')
    for (const key in this.testdata.profile.editedProfile) {
      if (this.testdata.profile.editedProfile.hasOwnProperty(key)) {
        cy.contains(this.testdata.profile.editedProfile[key])
      }
    }
  })
})
