#Seed data for word model
File.open(Rails.root.join("db/seeds", Rails.env, "seed.csv"), "r", encoding: "utf-8") do |f|
  f.each_line do |line|
    cols = line.chomp.split(",")
    Word.create(
    word: cols[0],
    meaning: cols[1],
    word_lang_id: "1", #English
    meaning_lang_id: "2", #chitumbuka
    created_by: "Admin",
    last_updated_by: "Admin"
    )
  end
end
