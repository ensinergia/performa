module OperatingCyclesHelper

  def get_graph(operating_cycle)
    code=""

    stages=operating_cycle.stages	
    clients=operating_cycle.clients	
    products=operating_cycle.services	

    unless stages.empty? || clients.empty? || products.empty?

      clients=get_clients(operating_cycle)
      products=get_products(operating_cycle)
      stages_str=""	
      from_clients=""
      to_products=""
      ant=""
      joins=""
      stages_joins=""
      follow=""
      colors=[]
      colors[0]="#F0E6AD"
      colors[1]="#F7DDB6"
      colors[2]="#E0B688"
      colors[3]="#FFA321"
      colors[4]="#FF9E7B"
      colors[5]="#FF7F71"
      colors[6]="#FF6149"
      ic=0;
      stages.each_with_index do |stage,index|
        steps_arr=stage.steps
        unless steps_arr.empty?
          labels=""
          steps=steps_arr.enum_for(:each_with_index).collect do |x, i| 
            stname=wrap_word(x.name,3)
            height=(x.name.split(" ").count / 3) 
            if height==0
              height=0.3
            else
              height=height*0.2
            end      

            if height<0.3
              height=0.3
            end
            labels+='"'+x.id.to_s+'.-'+stage.id.to_s+'" [label="'+stname+'", shape= box, style=filled,color=white,fontsize=9,fixedsize=true, width=1.8,height='+height.to_s+',text-wrap= auto, margin=0];'	

            if index==0 && i==0
              from_clients+='"clients" -> "'+x.id.to_s+'.-'+stage.id.to_s+'"[style=dashed];'
            end

            if i==steps_arr.count-1
              to_products+='"'+x.id.to_s+'.-'+stage.id.to_s+'"'+" -> products";	
              to_products+=	index==stages.count-1 ? "[style=dashed] ; " : "[style=invis] ; " 
            end

            if i==0
              from_clients+=index==0 ? " " : '"clients" -> '+'"'+x.id.to_s+'.-'+stage.id.to_s+'"'+"[style=invis]; ";
              '"'+x.id.to_s+'.-'+stage.id.to_s+'"'	
            else
              nextt='"'+x.id.to_s+'.-'+stage.id.to_s+'"'
              str= i==steps_arr.count-1 ?	'-> "'+x.id.to_s+'.-'+stage.id.to_s+'" ; ' : '-> "'+x.id.to_s+'.-'+stage.id.to_s+'" ; ' + nextt	

            end	

          end

          if stages.count-1>index
            nexts=stages[index+1].steps.first
            x=stages[index].steps.last
            unless nexts.nil?
              follow+='"'+x.id.to_s+'.-'+stage.id.to_s+'" -> "'+nexts.id.to_s+'.-'+stages[index+1].id.to_s+'"[style=dashed] ;'
            end
          end	

          ic= index>6 ?   0 : ic
          stages_str+='subgraph cluster_'+stage.id.to_s+' {
          fontsize=9,
          style=filled;
          color="'+colors[ic]+'";
          '+labels+'
          '+steps.join+'
          label = "'+stage.name+'";
          }'		

          ic+=1
        end   
      end	

      code='digraph G {
      labelloc=t;
      ordering="out";
      labelfontsize=16;
      splines=false;
      '+from_clients+'
      "clients" [shape=box,style=filled,color="#FF7E51", label="'+clients.join+'",fontsize=9];
      '+to_products+'
      "products" [shape=box,style=filled,color="#F9A366", label="'+products.join+'",fontsize=9];
      '+stages_str+'
      edge[constraint=false];
      '+follow+'
      '+joins+'
      '+stages_joins+'
      }'
    end

    code

  end  


  def get_clients(operating_cycle)
    clients_arr=operating_cycle.clients	
    tab='\n'
    unless clients_arr.empty?
    clients=clients_arr.enum_for(:each_with_index).collect do |x, j| 
      unless x.nil? || x.name.nil?
        #fname=wrap_word(x.name,5)
        "- "+x.name + tab
      end	

    end
    clients
  end
  end  


  def get_products(operating_cycle)
    products_arr=operating_cycle.services	
    tab='\n'
    products=products_arr.enum_for(:each_with_index).collect do |x, k| 
      unless x.nil?
        #fname=wrap_word(x.name,5)
        "- "+x.name + tab
      end	

    end
    products
  end  


  def wrap_word(name,nw)
    arrname=name.split(" ");
    fname=""
    tab='\n'
    arrname.each_with_index do |name,inc|
      fname+=" "+name
      if inc%nw==0 and inc!=0
        fname+=tab
      end  
    end  
    fname
  end  


end
