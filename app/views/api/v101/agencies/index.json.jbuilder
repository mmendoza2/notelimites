json.array!(@agencies) do |agencia|

        json.extract! agencia,
                      :id,
                      :name,
                      :uid,
                      :city,
                      :category_id,
                      :facebook_category
end
