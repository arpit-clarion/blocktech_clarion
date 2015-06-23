FactoryGirl.define do

  factory :historian do
    name Faker::Name.name
    address  Faker::Bitcoin.address
   # testnet_address Faker::Bitcoin.testnet_address
    bit_msg_address  Faker::Bitcoin.address
  end

end