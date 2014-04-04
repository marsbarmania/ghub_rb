napolitan = "neapolitan"
spagetti = "gtgtsgipgttptinggipsppaigsesgpetgstpatetisiesagaeaigttetepitiatsegssieeeeatepaaiagtpieataatppiitgiapsteitatiiatpetetetttgpetpaasipttssstpeeeggtiagtttegtiipestsasgpsepaasapttgattgiatppegitiatpasgatgepttggapesaeetaeissttggieietgspagesiipestipggstttpateptitiaetottissgggtttaipappgstsptttgtpispattgegstltiappseisapgistaiagteeiptptpisaieisagstapeteietgteiisgtiptstgtstasspeatspptitttatteastsgtptgtasggpniaaeteaisett"

current = 0

answer_str = spagetti.each_char.inject([]) { |answer, char|
  if char == napolitan[current]
    current += 1
    answer << "[#{char}]"
  else
    answer << "#{char}"
  end
}.join("")



