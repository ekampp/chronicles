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
# Where the name of the elements in the form is something other than can be
# inferred from the id.
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
        # transforms `_field` into `field` in case the form has no name.
        field = "#{(form[:name] || form[:id].split('_')[1])}_#{field}".split("_").compact.join("_")
        fill_in field, with: value rescue nil
        select value, from: field rescue nil
        attach_file field, value rescue nil
      end
      click_button form[:commit] || "commit"
    end
  end
end
