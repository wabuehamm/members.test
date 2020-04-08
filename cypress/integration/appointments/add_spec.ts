describe('Adding an event to the appointments feature', () => {
  beforeEach(() => {
    cy.fixCypressSpec('/cypress/integration/appointments/add_spec.ts')
    cy.login()
    cy.visit('/event_calendar/add')
  })

  it('should work', function () {
    cy.visit(`/event_calendar/list/${this.testdata.appointments.add['start_date']}?format=agenda`)
    cy.contains(this.testdata.appointments.add.title).should('not.exist')

    cy.visit('/event_calendar/add')

    for (const key of ['title', 'venue']) {
      cy.get(`[name=${key}]`).type(this.testdata.appointments.add[ key ])
    }

    for (const key of ['start_date', 'end_date']) {
      cy.get(`[name=${key}]`).clear()
      cy.get('[name=title]').click()
      cy.get(`[name=${key}]`).type(`{esc}${this.testdata.appointments.add[ key ]}`)
    }

    for (const key of ['start_time_hour', 'start_time_minute', 'end_time_hour', 'end_time_minute', 'region']) {
      cy.get(`[name=${key}]`).select(this.testdata.appointments.add[ key ])
    }

    cy.typeCkEditor(this.testdata.appointments.add['long_description'])
    cy.get('[name=submit]').click()

    cy.visit(`/event_calendar/list/${this.testdata.appointments.add['start_date']}?format=agenda`)
    cy.contains(this.testdata.appointments.add.title).click()
  })

})
