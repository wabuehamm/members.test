describe('Editing an event in the appointments feature', () => {
  beforeEach(function () {
    cy.fixCypressSpec('/cypress/integration/appointments/delete_spec.ts')
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
  })

  it('should work', function () {
    cy.get('[data-menu-item=entity-menu-toggle]').click()
    cy.get('[data-menu-item=delete').click()
    cy.visit(`/event_calendar/list/${this.testdata.appointments.add['start_date']}?format=agenda`)
    cy.contains(this.testdata.appointments.add.title).should('not.exist')
  })

})
