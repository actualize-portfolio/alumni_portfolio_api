# frozen_string_literal: true

Geocoder::Lookup::Test.add_stub(
  '121 N Lasalle, Chicago, IL, 60602', [
    { 'coordinates' => [41.956837, -87.688713] }
  ]
)

Geocoder::Lookup::Test.add_stub(
  '4000 N Western Suite 3, Chicago, IL, 60602', [
    { 'coordinates' => [] }
  ]
)
