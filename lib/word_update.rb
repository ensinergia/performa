#!/usr/bin/env ruby

require 'rubygems'
require 'zip/zip' # rubyzip gem
require 'nokogiri'

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
      arr_obj["Tr1"]=objective.id
      arr_obj["Tr2"]=objective.results+" "+I18n.t('views.operative_objective.new.through').upcase + " "+objective.actions
      arr_obj["Tr3"]=objective.area.name
      arr_obj["Tr4"]=objective.perspective
      arr_obj["Tr5"]=objective.responsable.nil? ?  ""  : objective.responsable.full_name
      arr_obj["Tr6"]=objective.init_date.strftime("%Y-%m-%d")
      arr_obj["Tr7"]=objective.final_date.strftime("%Y-%m-%d")

      x=1
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
          unless field.content==""

            if field.content=="Tr" and x<3
              field.content="Tr"+(x+5).to_s    
              x+=1
            end    
            puts field.content
            field.content=arr_obj[field.content]
          end  

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
    arr_obj["Tr1"]=objective.id
    arr_obj["Tr2"]=objective.results+" "+I18n.t('views.operative_objective.new.through').upcase + " "+objective.actions
    arr_obj["Tr3"]=objective.area.name
    arr_obj["Tr4"]=objective.perspective
    arr_obj["Tr5"]=objective.responsable.nil? ?  ""  : objective.responsable.full_name
    arr_obj["Tr6"]=objective.init_date.strftime("%Y-%m-%d")
    arr_obj["Tr7"]=objective.final_date.strftime("%Y-%m-%d")

    x=1
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
        unless field.content==""

          if field.content=="Tr" and x<3
            field.content="Tr"+(x+5).to_s    
            x+=1
          end    
          puts field.content
          field.content=arr_obj[field.content]
        end  

      end

    end

    doc.to_xml
  end
end  

