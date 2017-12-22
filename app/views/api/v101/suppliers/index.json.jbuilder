json.array!(@suppliers) do |supplier|
        json.extract! supplier,
                      :id,
                      :name,
                      :slug
end
