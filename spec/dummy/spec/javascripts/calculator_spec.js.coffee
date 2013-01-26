#= require calculator
describe "Calculator", ->

  subject = new Calculator()

  it "should add two digits", ->
    expect( subject.add(2,2) ).toBe(4)

