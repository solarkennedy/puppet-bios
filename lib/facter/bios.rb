if FileTest.exists?("/usr/sbin/dmidecode")

  # Add remove things to query here
  query = { 'BIOS Information'              => [ 'Vendor:', 'Version:', 'Release Date:' ],
            'System Information'            => [ 'Manufacturer:', 'Product Name:' , 'Serial Number:', 'Version:' ],
            'Chassis Information'           => ['Type:', 'Height:'],
            'Processor Information'         => ['Version:', 'Max Speed:'],
            'Memory Controller Information' => ['Maximum Memory Module Size:', 'Maximum Total Memory Size:' ] }
  
  # Run dmidecode only once
  output=%x{/usr/sbin/dmidecode 2>/dev/null}
  
  query.each_pair do |key,v|
    v.each do |value|
      output.split("Handle").each do |line|
        if line =~ /#{key}/  and line =~ /#{value} (\w.*)\n*./
          result = $1
          tag = key.split(' ')[0] + "_" + value.chomp(':').to_s.gsub(" ","_")
          Facter.add(tag) do
            confine :kernel => :Linux
            setcode do
              result
            end
          end # end facter.add
        end # end if line match
      end # end output line slpit
    end # end v.each
  end # end query.each_pair
end #endif
