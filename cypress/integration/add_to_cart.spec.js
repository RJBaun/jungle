describe('Jungle', () => {

  
  beforeEach(() => {
    cy.viewport(1440, 1000)
    cy.visit('localhost:3000')
  })

  it('should add 1 item to the cart from the home page', () => {
    cy.get('article:first').within(() => {
      cy.contains('Add').click()
    })
    cy.contains('My Cart').should('contain', '1')
  })
})