Given /^I search for "(.*?)"$/ do | input|
   text_field_selector = "searchBar marked:'searchBar'" 
   frankly_map(text_field_selector, "setText:", input) 
   frankly_map(text_field_selector, 'becomeFirstResponder')
   frankly_map("text_field_selector delegate", "searchBarSearchButtonClicked:", text_field_selector)
   #frankly_map( "textField placeholder:'Search'", "setText:", arg1 )
   #step %Q|I touch "Search"|
end
