#Seed data for word model
File.open("seeds.csv", "r", encoding: "utf-8") do |f|
  f.each_line do |line|
    cols = line.chomp.split(",")
    Word.create(
    word: cols[0],
    meaning: cols[1],
    word_lang: "1", #English
    meaning_lang: "2", #chitumbuka
    created_by: "Admin",
    last_updated_by: "Admin"
    )
  end
end
