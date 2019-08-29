#!/usr/bin/env ruby

def dotdotdot(grund, gren)
  (0..gren.length).to_a.reverse.each do |flex_længde|
    rød = gren[0...flex_længde]
    blad = gren[flex_længde..-1]
    indeks = grund.index(rød)
    next if indeks.nil?
    return grund[0...indeks] + gren
  end

  raise "Kunne ikke bøjne ord: #{grund}, #{gren}"
end

verbs = IO.read('verbs.txt').each_line.map do |linje|
  linje.chomp!
  linje.sub!(/^ */, '')
  linje.sub!(/ *$/, '')
  linje.sub!(/\s+/, ' ')
  tekst = linje

  # TODO handle det, der kommer efter '/'
  linje.sub!(/ *\/.*/, '')
  stykker = linje.split(', ')

  next if stykker.count == 1

  stykker.count == 4 or raise "? #{linje}"

  infinitiv = stykker[0]
  grund = infinitiv.sub(/^at /, '')

  bøjninger = stykker[1..-1].map do |bøjning|
    former = bøjning.split(' eller ')

    former.map do |form|
      # TODO: handle '(uofficielt)'?

      if form.start_with?('-')
        form = grund + form[1..-1]
      elsif form.start_with?('..')
        form = dotdotdot(grund, form[2..-1])
      end

      form
    end
  end

  imperativ = if grund.length == 2
                grund
              else
                grund.sub(/e$/, '').sub(/(\w)\1$/) { $1 }
              end

  {
    tekst: tekst,
    imperativ: imperativ,
    infinitiv: infinitiv,
    nutid: bøjninger[0],
    førid: bøjninger[1],
    datid: bøjninger[2],
  }
end.compact

verbs.sort_by {|v| v[:infinitiv]}.each do |verbum|
  bad = [:nutid, :førid, :datid].any? do |tid|
    verbum[tid].any? do |ord|
      !ord.match(/^(\(uofficielt\) )?[a-zøæå]+$/)
    end
  end

  if bad
    p verbum
  end
end
