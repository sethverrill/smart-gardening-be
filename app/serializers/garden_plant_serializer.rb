class GardenPlantSerializer
    def self.format(garden)
      
        {
        data: 
        garden.plants.distinct.map do |plant|
         
          {
            id: plant[:id],
            type: "plant",
            attributes: {
              name: plant[:name],
              description: plant[:description],
              img_url: plant[:img_url]
            }
          }
        end
      }
    end
end