{1 => "株式", 2 => "投資信託", 3 => "FX"}.each do |key, val|
  if Category.exists?(id: key)
    Category.find(key).update_attributes!(name: val)
  else
    Category.create!(id: key, name: val)
  end
end
