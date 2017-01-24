Preschool.destroy_all
Hour.destroy_all

# Enen
enen = Preschool.create!(
  name: 'Enens öppna förskola',
  url: 'http://malmo.se/Forskola--utbildning/Forskola/Forskola-och-pedagogisk-omsorg/Oppna-forskolor/Oppna-forskolor/Enens-oppna-forskola.html',
  preschool_type: :open,
  street_name: 'Celsiusgatan 13 C',
  postal_code: '21214',
  city: 'Malmö'
)

hours = [
  [1,'09:00', '14:30'],
  [2,'09:00', '14:30'],
  [3,'09:00', '14:30'],
  [4,'09:00', '13:00'],
  [5,'09:00', '14:30'],
]

hours.each do |array|
  Hour.create!(
    day_of_week: array[0],
    opens: array[1],
    closes: array[2],
    preschool: enen
  )
end

# Familjens hus
fhus = Preschool.create!(
  name: 'Familjens Hus',
  url: 'http://malmo.se/Forskola--utbildning/Forskola/Forskola-och-pedagogisk-omsorg/Oppna-forskolor/Oppna-forskolor/Familjens-Hus-oppna-forskola.html',
  preschool_type: :open,
  street_name: 'Norra Parkgatan 23',
  postal_code: '21422',
  city: 'Malmö'
)

hours = [
  [1,'08:00', '12:00'],
  [2,'08:00', '12:00'],
  [3,'08:00', '12:00'],
  [4,'08:00', '12:00'],
  [5,'08:00', '12:00'],
  [1,'13:00', '16:00', 'För familjer med barn upp till 10 månader.'],
  [2,'13:00', '16:00', 'För familjer med barn upp till 10 månader.'],
]

hours.each do |array|
  Hour.create!(
    day_of_week: array[0],
    opens: array[1],
    closes: array[2],
    note: array[3],
    preschool: fhus
  )
end

# Barnens hus
bhus = Preschool.create!(
  name: 'Barnens Hus',
  url: 'http://malmo.se/Forskola--utbildning/Forskola/Forskola-och-pedagogisk-omsorg/Oppna-forskolor/Oppna-forskolor/Barnens-Hus-oppna-forskola.html',
  preschool_type: :open,
  street_name: 'Möllevångsgatan 24',
  postal_code: '21420',
  city: 'Malmö'
)

hours = [
  [1,'09:00', '15:00'],
  [2,'09:00', '12:30'],
  [3,'09:00', '12:30'],
  [4,'09:00', '15:00'],
  [5,'09:00', '15:00'],
  [2,'13:30', '16:00', 'För familjer med barn upp till 10 månader.'],
]

hours.each do |array|
  Hour.create!(
    day_of_week: array[0],
    opens: array[1],
    closes: array[2],
    note: array[3],
    preschool: bhus
  )
end

# Familjehuset Nydala
nydala = Preschool.create!(
  name: 'Familjehuset Nydala',
  url: 'http://malmo.se/Forskola--utbildning/Forskola/Forskola-och-pedagogisk-omsorg/Oppna-forskolor/Oppna-forskolor/Familjehuset-Nydala-oppna-forskolan.html',
  preschool_type: :open,
  street_name: 'Nydalatorget 2',
  postal_code: '21455',
  city: 'Malmö'
)

hours = [
  [1,'13:00', '16:00'],
  [2,'09:00', '16:00'],
  [3,'09:00', '14:00'],
  [4,'09:00', '16:00'],
  [5,'09:00', '16:00'],
  [1,'11:00', '13:00', 'Babycafé'],
]

hours.each do |array|
  Hour.create!(
    day_of_week: array[0],
    opens: array[1],
    closes: array[2],
    note: array[3],
    preschool: nydala
  )
end

# Kompassen
nydala = Preschool.create!(
  name: 'Kompassen',
  url: 'http://kompassensoppnaforskola.blogspot.se/',
  preschool_type: :open,
  street_name: 'Rasmusgatan 1',
  postal_code: '21446',
  city: 'Malmö'
)

hours = [
  [1,'08:30', '14:30'],
  [2,'08:30', '14:30'],
  [3,'08:30', '14:30'],
  [4,'08:30', '14:30'],
  [5,'08:30', '14:30'],
]

hours.each do |array|
  Hour.create!(
    day_of_week: array[0],
    opens: array[1],
    closes: array[2],
    note: array[3],
    preschool: nydala
  )
end
