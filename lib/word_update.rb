#!/usr/bin/env ruby

require 'rubygems'
require 'zip/zip' # rubyzip gem
require 'nokogiri'

class Zipped
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


class WordXmlFile
  def self.open(path, &block)
    self.new(path, &block)
  end

  def initialize(path, &block)
    @replace = {}
    if block_given?
      @zip = Zip::ZipFile.open(path)
      yield(self)
      @zip.close
    else
      @zip = Zip::ZipFile.open(path)
    end
  end

  def merge(arr)
    xml = @zip.read("word/document.xml")
    doc = Nokogiri::XML(xml) {|x| x.noent}
    arr.each do |change|
      (doc/"//w:t").each do |field|
        if field.content==change[:old]
          field.content=change[:new]
        end
      end
    end
    @replace["word/document.xml"] = doc.serialize :save_with => 0
  end


  def change_values(body,table)
  end  

  def update(objectives)
    file = "#{Rails.root}/public/docx/template/word/document.xml"
    xml = filecfopen(file)
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


    @replace["word/document.xml"] = doc.to_xml :save_with => 0
  end

  def new_save(objectives)
    update(objectives)
    out_file = "#{Rails.root}/public/docx/#{I18n.t('views.operative_objective.card.output')}.docx"
  end  


  def save(path)
    Zip::ZipFile.open(path, Zip::ZipFile::CREATE) do |out|
      @zip.each do |entry|
        out.get_output_stream(entry.name) do |o|
          if @replace[entry.name]
            o.write(@replace[entry.name])
          else
            o.write(@zip.read(entry.name))
          end
        end
      end
    end
    @zip.close
  end
end


