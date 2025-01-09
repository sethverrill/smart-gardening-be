
Garden.destroy_all
Plant.destroy_all
GardenPlant.destroy_all

garden1 = Garden.create!(
  name: "Vegetable Garden",
  hardiness_zone: "6a",
  sunlight: "Full Sun",
  soil_type: "Loam",
  water_needs: "High",
  purpose: "Edible"
)

garden2 = Garden.create!(
  name: "Flower Garden",
  hardiness_zone: "6b",
  sunlight: "Partial Shade",
  soil_type: "Sandy",
  water_needs: "Low",
  purpose: "Aesthetic"
)

garden3 = Garden.create!(
  name: "Pollinator Garden",
  hardiness_zone: "5b",
  sunlight: "Full Shade",
  soil_type: "Clay",
  water_needs: "Medium",
  purpose: "Pollinator"
)

garden4 = Garden.create!(
  name: "Coverage Garden",
  hardiness_zone: "7a",
  sunlight: "Partial Shade",
  soil_type: "Rocky",
  water_needs: "Low",
  purpose: "Ground Cover"
)

tomato = Plant.create!(
  name: "Tomato",
  img_url: "https://upload.wikimedia.org/wikipedia/commons/8/89/Tomato_je.jpg",
  description: "A popular vegetable that thrives in full sun."
)

carrot = Plant.create!(
  name: "Carrot",
  img_url: "https://upload.wikimedia.org/wikipedia/commons/4/4b/Carrot.jpg",
  description: "A root vegetable that grows well in loamy soil."
)

lavender = Plant.create!(
  name: "Lavender",
  img_url: "https://upload.wikimedia.org/wikipedia/commons/6/6d/Lavandula_angustifolia_02.jpg",
  description: "A fragrant plant loved by pollinators."
)

sunflower = Plant.create!(
  name: "Sunflower",
  img_url: "https://upload.wikimedia.org/wikipedia/commons/4/40/Sunflower_sky_backdrop.jpg",
  description: "An iconic flower that attracts bees and birds."
)

rose = Plant.create!(
  name: "Rose",
  img_url: "https://upload.wikimedia.org/wikipedia/commons/4/4d/Rose_flower.jpg",
  description: "A classic flower known for its beauty and fragrance."
)

tulip = Plant.create!(
  name: "Tulip",
  img_url: "https://upload.wikimedia.org/wikipedia/commons/4/4c/Tulip_-_floriade_canberra.jpg",
  description: "A colorful spring-blooming flower."
)

moss = Plant.create!(
  name: "Moss",
  img_url: "https://upload.wikimedia.org/wikipedia/commons/4/4b/Moss_on_tree_trunk.jpg",
  description: "A low-maintenance ground cover that thrives in shaded areas."
)

clover = Plant.create!(
  name: "Clover",
  img_url: "https://upload.wikimedia.org/wikipedia/commons/5/5d/Trifolium_repens_-_Keila.jpg",
  description: "A hardy ground cover plant that prevents soil erosion."
)

  GardenPlant.create!(garden: garden1, plant: tomato)
  GardenPlant.create!(garden: garden1, plant: carrot)
  
  GardenPlant.create!(garden: garden3, plant: lavender)
  GardenPlant.create!(garden: garden3, plant: sunflower)
  
  GardenPlant.create!(garden: garden2, plant: rose)
  GardenPlant.create!(garden: garden2, plant: tulip)
  
  GardenPlant.create!(garden: garden4, plant: moss)
  GardenPlant.create!(garden: garden4, plant: clover)