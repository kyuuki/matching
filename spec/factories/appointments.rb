FactoryGirl.define do
  factory :appointment do
    item nil
    user nil
    place "MyString"
    datetime "2016-09-30 12:54:55"
    memo "MyText"
    star 1
    review "MyText"
    item_title "MyString"
    item_detail "MyText"
    item_execution_time 1
    item_price 1
    item_service "MyString"
    item_available_datetime "MyString"
    item_available_japan_place "MyString"
  end
end
