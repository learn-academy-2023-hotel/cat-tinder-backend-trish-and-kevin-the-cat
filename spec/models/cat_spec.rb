require 'rails_helper'

RSpec.describe Cat, type: :model do
  it "should validate name exists in database entry" do
    # assign ruby variable to Cat.create and pass it all the required info EXCEPT name
    cat = Cat.create(age:3, enjoys:'reading by candlelight', image: 'https://somecatpic.com')
    # if cat name is not present, throw an error
    expect(cat.errors[:name]).to_not be_empty
  end

  it "should validate age exists in db entry" do
    cat = Cat.create(name:'Junior', enjoys:'testing using RSpec', image:'https://someimage.com')
    expect(cat.errors[:age]).to_not be_empty
  end

  it "should validate enjoys exits in the db entry" do
    cat = Cat.create(name: "Junior", age:3, image: 'https://somecatpic.com')
    expect(cat.errors[:enjoys]).to_not be_empty
  end

end