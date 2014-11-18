books = {'title' => "Gourd of the Flies", 
          'author' => "J.W. Gourding"}

books2 = [{'title' => "Design Patterns", 
              'author(s)'=> ["John Vlissides", "Richard Helm", "Ralph Johnson", "Erich Gamma"]},
         {'title' =>"Patterns of Enterprise Application Architecture", 
            'author(s)' => ["Martin Fowler"]},  #keep data types consistent - since the first authors is an array, all other authors must be an array in case you call an .each method on authors          
         {'title' = "Domain Driven Design",
          'author(s)' => ["Eric Evans"]}
        ]

volunteer = {'name' => 'Alice',
 'age' => 25, 
 'phone number' => '555-555-5555',
  'position' => 'event receptionist'}

states = {'Rhode Island' => {'abbreviation' => 'RI',
                       'population' => 1050292, 
                      'people' => 'Rhode Islanders', 
                      'capital' => 'Providence',
                      'populous cities' => ['Warwick', 'Cranston'], 
                      'median income' => '$54,619',
                      'governor' => 'Lincoln Chafee'}
        }

laptop = {'type' => 'Apple Macbook Air',
  'drive' => {size: 256, type: "SSD"},
  'RAM' => '8GB',
  'display' => 'Retina',
  'processor' => {manufacturer: 'Intel', model: 'i7'},
  'software' => ['iPhoto', 'Safari', 'iMovie', 'iMessage']
         }

nickdogs = [{'name' => 'Maple',
      'age' => 4,
      'breed' => 'pitbull',
      'color' => 'brown',
      'activities' => ['tug o war', 'swimming']
            },

            {'name' => 'Atlas',
      'age' => 3,
      'breed' => 'boxer',
      'activities' => ['fetch', 'swimming']
            }
    ]
          
favrestaurants = [
  {name: "Patrick's Pizza Place",
   address: "716 Congress Ave",
   health_score: "100",
   menu: {appetizers: ["mozerella sticks", "calzone", "garlic knots"],
             entrees: ["chicken parmigiana", "slice of pizza","spaghetti & eggplant"],
             desserts: ["tiramisu", "cannoli", "cheesecake"]
         }
  }
]

  class Restaurants
    attr_accessor :name, :address, :health_score, :menu
   
    def initialize(name, address, health score)
      @name, @address, @health_score = name, address, health_score   #yo... you can do it this way      
      @menu = {appetizers: [], entrees: [], desserts:[]}
    end

    def add_menu_item(category, item)
      @menu[category] << item
    end
  end