#!/usr/bin/env ruby

class OrdList

  attr_reader :verber, :fejl

  def initialize
    @verber = []
    @fejl = []
    parse
    tjek
  end

  private

  def find_vælge(tekst)
    return tekst.split(' eller ') if tekst.include?(' eller ')

    if m = tekst.match(/^(\S+) \(eller (\S+)\)$/)
      return [ m[1], m[2] ]
    end

    [tekst]
  end

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

  def parse
    IO.read('verber.txt').each_line do |linje|
      linje.chomp!
      linje.sub!(/^ */, '')
      linje.sub!(/ *$/, '')
      linje.sub!(/\s+/, ' ')
      tekst = linje

      # TODO handle det, der kommer efter '/'
      linje.sub!(/ *\/.*/, '')
      stykker = linje.split(/\s*,\s*/)

      if stykker.count != 4
        fejl << { linje: linje, forklaring: "der skal være fire stykker" }
        next
      end

      infinitiv = stykker[0]
      grund = infinitiv.sub(/^at /, '')

      bøjninger = stykker[1..-1].map do |bøjning|
        former = find_vælge(bøjning)

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

      verber << {
        tekst: tekst,
        imperativ: imperativ,
        infinitiv: infinitiv,
        nutid: bøjninger[0],
        førid: bøjninger[1],
        datid: bøjninger[2],
      }
    end

    @verber = verber
    @fejl = fejl
  end

  def tjek
    verber.sort_by {|v| v[:infinitiv]}.each do |verbum|
      dårligt = [:nutid, :førid, :datid].map do |tid|
        verbum[tid].count do |ord|
          !ord.match(/^(\(uofficielt\) )?[a-zøæå]+$/)
        end
      end.reduce(&:+)

      verbum[:antal_dårligt] = dårligt
    end
  end
end
