describe('The appointments feature', () => {
  beforeEach(() => {
    cy.fixCypressSpec('/cypress/integration/appointments_spec.ts')
    cy.login()
    cy.visit('/event_calendar/list/')
  })

  it('is reachable', function () {
    cy.contains(this.identifiers.appointments.title)

    cy.document().toMatchImageSnapshot({
      name: 'appointments',
      blackout: [
        '.elgg-pagination',
        '.event_calendar_paged',
        '.elgg-module-aside'
      ]
    })
  })

  it('should have appointments', function () {
    cy.get('.event_calendar_paged_title').should('have.length.of.at.least', this.counts.appointments.minEntries)
  })

  it('should have a working ical export', function () {
    cy.get('[data-menu-item=ical_export]').click()
    cy.contains(this.identifiers.appointments.icalExport)
    cy.request({
      method: 'POST',
      form: true,
      body: this.testdata.appointments.add,
      url: '/action/event_calendar/edit'
    })
    cy.request({
      method: 'POST',
      url: '/action/event_calendar/export',
      form: true,
      body: this.testdata.appointments.export
    })
      .then(
        resp => {
          expect(resp.body).to.contain(`SUMMARY:${this.testdata.appointments.add.title}`)
        }
      )
  })
  it.only('should have a working ical import', function () {
    cy.visit(`/event_calendar/list/${this.testdata.appointments.import.date}?format=agenda`)
    cy.contains(this.testdata.appointments.import.title).should('not.exist')
    cy.visit('/event_calendar/list/')
    cy.get('[data-menu-item=ical_import]').click()
    cy.get('[name=ical_file]').attachFile('test.ics', 'text/calendar')
      .trigger('change', { force: true })
    cy.get('.elgg-form-event-calendar-import .elgg-button-submit').click()
    cy.visit(`/event_calendar/list/${this.testdata.appointments.import.date}?format=agenda`)
    cy.contains(this.testdata.appointments.import.title)
  })
})
