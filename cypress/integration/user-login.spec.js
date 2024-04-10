describe('jungle', () => {

  beforeEach(() => {
    cy.visit('localhost:3000')
  })

  it('should register a new user', () => {
    cy.contains('Login').click()
    cy.get('ul .dropdown-menu ').within(() => {
      cy.contains('Register').click()
    })
    cy.get('input[name="user[first_name]"]').type('Vinny')
    cy.get('input[name="user[last_name]"]').type('Paws')
    cy.get('input[name="user[email]"]').type('vp@example.com')
    cy.get('input[name="user[password]"]').type('password')
    cy.get('input[name="user[password_confirmation]"]').type('password')
    cy.get('input[type="submit"]').click()
    cy.contains('Login').click()
    cy.contains('Logout').should('exist')
  })

  it('should log a user in', () => {
    cy.contains('Login').click()
    cy.get('ul .dropdown-menu li:first').click()
    cy.get('input[name="email"]').type('vp@example.com')
    cy.get('input[name="password"]').type('password')
    cy.get('form[action="/login"]').submit()
    cy.contains('Login').click()
    cy.contains('Logout').should('exist')
  })
})