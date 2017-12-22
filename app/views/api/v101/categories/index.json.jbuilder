json.array!(@categories) do |categoria|
        json.extract! categoria,
                      :id,
                      :name,
                      :slug,
                      :image
end
