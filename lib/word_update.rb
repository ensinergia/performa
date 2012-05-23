#!/usr/bin/env ruby

require 'rubygems'
require 'zip/zip' # rubyzip gem
require 'nokogiri'
require 'date'

class Zipped
  
  def follow_dir(path,base,archive,objectives)
    Dir[path].each_with_index do |fl,i|
      if fl.include?("template/_rels")
        self.add_buffer(archive,base,base+"_rels/.rels",objectives)
      end  
      if File.directory?(fl)
        self.follow_dir(fl+"/*",base,archive,objectives)
      else  
        self.add_buffer(archive,base,fl,objectives)
      end  
      
    end
  end  

  def add_buffer(archive,base,fl,objectives)
        txt=""
        file_name=fl.gsub(base,"")
          File.open(fl, "r") do  |f|
            txt+=f.read
          end
          if file_name.include?("word/document.xml")
              txt=self.update(objectives) 
          end    
          archive.add_buffer(file_name,txt)
  end  
  
  
  def update(objectives)
    file = "#{Rails.root}/public/docx/template/word/document.xml"
    xml = File.open(file)
    doc = Nokogiri::XML(xml) {|x| x.noent}
    body=doc.xpath("//w:body").first

    #objectives.each do |objective|
    table=doc.xpath("//w:tbl").first.clone      
    # body<<table
    #end  

    title=nil

    objectives.each do |objective|
      puts objective.id
      arr_obj=Hash.new
      arr_obj[0]=objective.id
      arr_obj[1]=objective.results+" "+I18n.t('views.operative_objective.new.through').upcase + " "+objective.actions
      arr_obj[2]=objective.area.name
      arr_obj[3]=objective.perspective
      arr_obj[4]=objective.responsable.nil? ?  ""  : objective.responsable.full_name
      arr_obj[5]=objective.init_date.to_date unless objective.init_date.nil?
      arr_obj[6]=objective.final_date.to_date unless objective.final_date.nil?

      x=0
      body.xpath("//w:t").each do |field|

        case field.content
        when 'Titulo1'
          title=field.clone
          title.content=""
          field.content=I18n.t('views.operative_objective.card.title') + objective.area.name
        when 'H1'
          field.content=I18n.t('views.operative_objective.card.h1')    
        when 'H2'
          field.content=I18n.t('views.operative_objective.card.h2')                                
        end

        if field.content.include?("Th")
          field.content=I18n.t('views.operative_objective.card.'+field.content.downcase)  
        end

        if field.content.include?("Tr")  
            puts field.content
            field.content=arr_obj[x] 
            x+=1
            puts "=>"+field.content
        end

      end
      #puts "=> "+objective.id.to_s
      #body<<newtable.to_xml
      unless title.nil?
        body<<title
        body<<title
      end
      body<<table.clone
    end


    objective=objectives.first
    arr_obj=Hash.new
      arr_obj[0]=objective.id
      arr_obj[1]=objective.results+" "+I18n.t('views.operative_objective.new.through').upcase + " "+objective.actions
      arr_obj[2]=objective.area.name
      arr_obj[3]=objective.perspective
      arr_obj[4]=objective.responsable.nil? ?  ""  : objective.responsable.full_name
      arr_obj[5]=objective.init_date.to_date unless objective.init_date.nil?
      arr_obj[6]=objective.final_date.to_date unless objective.final_date.nil?
    x=0
    body.xpath("//w:t").each do |field|

      case field.content
      when 'Titulo1'
        title=field.clone
        title.content=""
        field.content=I18n.t('views.operative_objective.card.title') + objective.area.name
      when 'H1'
        field.content=I18n.t('views.operative_objective.card.h1')    
      when 'H2'
        field.content=I18n.t('views.operative_objective.card.h2')                                
      end

      if field.content.include?("Th")
        field.content=I18n.t('views.operative_objective.card.'+field.content.downcase)  
      end

       if field.content.include?("Tr")  
            puts field.content
            field.content=arr_obj[x] 
            x+=1
            puts "=>"+field.content
        end

    end

    doc.to_xml
  end
end  

