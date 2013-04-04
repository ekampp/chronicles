# This will fill out the form defined in the `form` hash, and it will fill the
# form elements with the data from the `atrs` hash. So you need to define both
# before incuding this context.
#
# The smallest, possible example:
#
#   include_context :fill_and_submit_form do
#     let(:form){ {id: "new_user_form" } }
#     let(:atrs) { {name: "Weeble & Bob"} }
#   end
#
# Another example, where the id of the submit button is something other than
# commit.
#
#   include_context :fill_and_submit_form do
#     let(:form){ {id: "new_user_form", commit: "submit" } }
#     let(:atrs) { {name: "Weeble & Bob"} }
#   end
#
# Lastly an example where the name of the elements in the form is something
# other than can be inferred from the id.
#
#   include_context :fill_and_submit_form do
#     let(:form){ {id: "new_user_form", name: "person" } }
#     let(:atrs) { {name: "Weeble & Bob"} }
#   end
#
shared_context :fill_and_submit_form do
  before do
    within form[:id] do
      atrs.compact.each do |field, value|
        field = "#{(form[:name] || form[:id].split('_')[1])}_#{field}".split("_").compact.join("_")
        begin
          fill_in field, with: value
        rescue
          begin
            select value, from: field
          rescue
            raise "Could not fill in #{field}!"
          end
        end
      end
      click_button form[:commit] || "commit"
    end
  end
end
