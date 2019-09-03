class Bøjning
  class << self

    def bøj(grund, form)
      if form.start_with?('-')
        form = grund + form[1..-1]
      elsif form.start_with?('..')
        form = dotdotdot(grund, form[2..-1])
      else
        form
      end
    end

    def dotdotdot(grund, gren)
      (0..gren.length).to_a.reverse.each do |flex_længde|
        rød = gren[0...flex_længde]
        blad = gren[flex_længde..-1]
        indeks = grund.index(rød)
        next if indeks.nil?
        return grund[0...indeks] + gren
      end

      raise KanIkkeBøjeException, "Kunne ikke bøjne ord: #{grund}, #{gren}"
    end

  end

  class KanIkkeBøjeException < StandardError ; end
end
