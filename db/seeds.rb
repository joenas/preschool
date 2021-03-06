Preschool.destroy_all
PreschoolUrl.destroy_all
SiteChange.destroy_all
Hour.destroy_all

# Enen
enen = Preschool.create!(
  name: 'Enens öppna förskola',
  url: 'http://malmo.se/Forskola--utbildning/Forskola/Forskola-och-pedagogisk-omsorg/Oppna-forskolor/Oppna-forskolor/Enens-oppna-forskola.html',
  street_name: 'Celsiusgatan 13 C',
  postal_code: '21214',
  city: 'Malmö'
)

PreschoolUrl.create!({
  url: "http://malmo.se/Forskola--utbildning/Forskola/Forskola-och-pedagogisk-omsorg/Oppna-forskolor/Oppna-forskolor/Enens-oppna-forskola.html",
  hours_element: "#h-Varaoppettiderar + p",
  extras_element: ".sv-blockquote",
  preschool: enen
})

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
  street_name: 'Norra Parkgatan 23',
  postal_code: '21422',
  city: 'Malmö'
)

PreschoolUrl.create!({
  url: "http://malmo.se/Forskola--utbildning/Forskola/Forskola-och-pedagogisk-omsorg/Oppna-forskolor/Oppna-forskolor/Familjens-Hus-oppna-forskola.html",
  hours_element: "#h-Oppenforskolaoppettider + p",
  extras_element: "#h-Babyoppet + p",
  preschool: fhus
})

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
  street_name: 'Möllevångsgatan 24',
  postal_code: '21420',
  city: 'Malmö'
)

PreschoolUrl.create!({
  url: "http://malmo.se/Forskola--utbildning/Forskola/Forskola-och-pedagogisk-omsorg/Oppna-forskolor/Oppna-forskolor/Barnens-Hus-oppna-forskola.html",
  hours_element: "#Ingress + .sv-text-portlet-content",
  extras_element: "#Ingress + .sv-text-portlet-content p:last-child",
  preschool: bhus
})


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
  street_name: 'Nydalatorget 2',
  postal_code: '21455',
  city: 'Malmö'
)

PreschoolUrl.create!({
  url: "http://malmo.se/Forskola--utbildning/Forskola/Forskola-och-pedagogisk-omsorg/Oppna-forskolor/Oppna-forskolor/Familjehuset-Nydala-oppna-forskolan.html",
  hours_element: "#Text1 + .sv-text-portlet-content",
  extras_element: "#Text + .in-focus",
  preschool: nydala
})


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
kompassen = Preschool.create!(
  name: 'Kompassen',
  url: 'http://malmo.se/Forskola--utbildning/Forskola/Forskola-och-pedagogisk-omsorg/Oppna-forskolor/Oppna-forskolor/Kompassens-oppna-forskola.html',
  street_name: 'Rasmusgatan 1',
  postal_code: '21446',
  city: 'Malmö'
)

PreschoolUrl.create!({
  url: "http://malmo.se/Forskola--utbildning/Forskola/Forskola-och-pedagogisk-omsorg/Oppna-forskolor/Oppna-forskolor/Kompassens-oppna-forskola.html",
  hours_element: ".sv-decoration-Huvudbild + .sv-text-portlet",
  extras_element: "#breadcrumbs",
  preschool: kompassen
})

PreschoolUrl.create!({
  url: "http://kompassensoppnaforskola.blogspot.se/",
  hours_element: ".date-outer:first-child'",
  extras_element: "#header-inner",
  preschool: kompassen
})

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
    preschool: kompassen
  )
end

# Pusselbiten
pusselbiten = Preschool.create!(
  name: 'Pusselbiten',
  url: 'http://malmo.se/Forskola--utbildning/Forskola/Forskola-och-pedagogisk-omsorg/Oppna-forskolor/Oppna-forskolor/Pusselbitens-oppna-forskola.html',
  street_name: 'Eriksfältsgatan 16 A',
  postal_code: '21432',
  city: 'Malmö',
  note: 'Sångstund på måndag, onsdag, fredag kl. 11.00. Skapande på tisdag och torsdag kl. 8.30-14.30.'
)

PreschoolUrl.create!({
  url: "http://malmo.se/Forskola--utbildning/Forskola/Forskola-och-pedagogisk-omsorg/Oppna-forskolor/Oppna-forskolor/Pusselbitens-oppna-forskola.html",
  hours_element: "#Text2 + .in-focus",
  extras_element: "#Text3 + .in-focus",
  preschool: pusselbiten
})

hours = [
  [1,'08:30', '15:00'],
  [2,'08:30', '15:00'],
  [3,'08:30', '15:00'],
  [4,'08:30', '15:00'],
  [5,'08:30', '15:00'],
]

hours.each do |array|
  Hour.create!(
    day_of_week: array[0],
    opens: array[1],
    closes: array[2],
    note: array[3],
    preschool: pusselbiten
  )
end

# Sesam Familjecentral
sesam = Preschool.create!(
  name: 'Sesam Familjecentral',
  url: 'http://malmo.se/Forskola--utbildning/Forskola/Forskola-och-pedagogisk-omsorg/Oppna-forskolor/Oppna-forskolor/Oppen-forskola---Sesam-Familjecentral.html',
  street_name: 'Västra Kattarpsvägen 65',
  postal_code: '21365',
  city: 'Malmö',
)

PreschoolUrl.create!({
  url: "http://malmo.se/Forskola--utbildning/Forskola/Forskola-och-pedagogisk-omsorg/Oppna-forskolor/Oppna-forskolor/Oppen-forskola---Sesam-Familjecentral.html",
  hours_element: "#h-Oppettider + p",
  extras_element: "#Text2 + .in-focus",
  preschool: sesam
})

hours = [
  [1,'09:00', '16:00'],
  [2,'09:00', '16:00'],
  [3,'11:30', '15:00', 'Babyöppet, bebisar 0-18 månader'],
  [4,'09:00', '16:00'],
  [5,'09:00', '16:00'],
]

hours.each do |array|
  Hour.create!(
    day_of_week: array[0],
    opens: array[1],
    closes: array[2],
    note: array[3],
    preschool: sesam
  )
end

# Solstrålen Familjecentral
solstral = Preschool.create!(
  name: 'Solstrålen Familjecentral',
  url: 'http://malmo.se/Forskola--utbildning/Forskola/Forskola-och-pedagogisk-omsorg/Oppna-forskolor/Oppna-forskolor/Oppen-forskola---Familjecentralen-Solstralen.html',
  street_name: 'Von Troils Väg 8 B',
  postal_code: '21373',
  city: 'Malmö',
)

PreschoolUrl.create!({
  url: "http://malmo.se/Forskola--utbildning/Forskola/Forskola-och-pedagogisk-omsorg/Oppna-forskolor/Oppna-forskolor/Oppen-forskola---Familjecentralen-Solstralen.html",
  hours_element: "#h-Oppettider + p",
  extras_element: "#breadcrumbs",
  preschool: solstral
})

hours = [
  [1,'09:00', '14:00'],
  [1,'14:00', '16:30', 'Bokad grupp'],
  [2,'09:00', '16:00'],
  [3,'10:30', '15:00', 'Babycafé, barn mellan 0- 18 månader)'],
  [4,'09:00', '11:00', 'Bokad grupp'],
  [4,'11:00', '16:00'],
  [5,'09:00', '12:00'],
  [5,'12:00', '15:00', 'Walk and talk'],
]

hours.each do |array|
  Hour.create!(
    day_of_week: array[0],
    opens: array[1],
    closes: array[2],
    note: array[3],
    preschool: solstral
  )
end

# Hera
hera = Preschool.create!(
  name: 'Hera',
  url: 'http://malmo.se/Forskola--utbildning/Forskola/Forskola-och-pedagogisk-omsorg/Oppna-forskolor/Oppna-forskolor/Oppna-forskolan-Hera.html',
  street_name: 'Västra Kattarpsvägen 65',
  postal_code: '21365',
  city: 'Malmö',
)

PreschoolUrl.create!({
  url: "http://malmo.se/Forskola--utbildning/Forskola/Forskola-och-pedagogisk-omsorg/Oppna-forskolor/Oppna-forskolor/Oppna-forskolan-Hera.html",
  hours_element: "#h-Oppettider + p",
  extras_element: "#breadcrumbs",
  preschool: hera
})

hours = [
  [1,'12:00', '15:30'],
  [2,'12:00', '15:30'],
  [3,'12:00', '15:00'],
  [4,'12:00', '15:30'],
  [5,'12:00', '15:30'],
]

hours.each do |array|
  Hour.create!(
    day_of_week: array[0],
    opens: array[1],
    closes: array[2],
    note: array[3],
    preschool: hera
  )
end
