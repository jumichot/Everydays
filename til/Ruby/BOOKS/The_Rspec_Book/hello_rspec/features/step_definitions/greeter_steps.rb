class RspecGreeter
  def greet
    "Hello Cucumber!"
  end
end

Given(/^a greeter$/) do
  @greeter = RspecGreeter.new
end

When(/^I send it the greet message$/) do
  @message = @greeter.greet
end

Then(/^I should see "(.*?)"$/) do |greeting|
  expect(@message).to eq greeting
end
