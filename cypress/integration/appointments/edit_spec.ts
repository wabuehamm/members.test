describe('Editing an event in the appointments feature', () => {
  beforeEach(function () {
    cy.fixCypressSpec('/cypress/integration/appointments/edit_spec.ts')
    cy.login()
    cy.log('Adding test appointment')
    cy.request({
      method: 'POST',
      form: true,
      body: this.testdata.appointments.add,
      url: '/action/event_calendar/edit'
    })
    cy.visit(`/event_calendar/list/${this.testdata.appointments.add['start_date']}?format=agenda`)
    cy.contains(this.testdata.appointments.add.title).click()
    cy.get('[data-menu-item=entity-menu-toggle]').click()
    cy.get('[data-menu-item=edit').click()
  })

  it('should have a valid edit form', function () {
    cy.document().toMatchImageSnapshot({
      name: `appointments_edit.${Cypress.env('viewtype')}`,
    })
  })

  it('should work', function () {
    for (const key of ['title', 'venue']) {
      cy.get(`[name=${key}]`).clear().type(this.testdata.appointments.edit[ key ])
    }

    for (const key of ['start_date', 'end_date']) {
      cy.get(`[name=${key}]`).clear()
      cy.get('[name=title]').click()
      cy.get(`[name=${key}]`).type(`{esc}${this.testdata.appointments.edit[ key ]}`)
    }

    for (const key of ['start_time_hour', 'start_time_minute', 'end_time_hour', 'end_time_minute', 'region']) {
      cy.get(`[name=${key}]`).select(this.testdata.appointments.edit[ key ])
    }

    cy.typeCkEditor(this.testdata.appointments.edit['long_description'])
    cy.get('[name=submit]').click()

    cy.visit(`/event_calendar/list/${this.testdata.appointments.edit['start_date']}?format=agenda`)
    cy.contains(this.testdata.appointments.edit.title).click()

    for (const testString of this.testdata.appointments.editVerification) {
      cy.contains(testString)
    }
  })

})
