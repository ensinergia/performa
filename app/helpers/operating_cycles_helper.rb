module OperatingCyclesHelper

  def get_graph(operating_cycle)
    code=""
    
    stages=operating_cycle.stages	
    unless stages.empty?

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
        labels=""
        steps=steps_arr.enum_for(:each_with_index).collect do |x, i| 
          labels+='"'+x.id.to_s+'.-'+stage.id.to_s+'" [label="'+x.name+'", shape= box, style=filled,color=white,fontsize=9];'	

          if index==0 && i==0
            from_clients+='"clients" -> "'+x.id.to_s+'.-'+stage.id.to_s+'"[style=dashed];'
          end

          if i==steps_arr.count-1
            to_products+='"'+x.id.to_s+'.-'+stage.id.to_s+'"'+" -> products";	
            to_products+=	index==stages.count-1 ? "[style=bold] ; " : "[style=invis] ; " 
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
          follow+='"'+x.id.to_s+'.-'+stage.id.to_s+'" -> "'+nexts.id.to_s+'.-'+stages[index+1].id.to_s+'"[style=dashed] ;'
        end	

        ic= index>6 ?   0 : ic
        stages_str+='subgraph cluster_'+stage.id.to_s+' {
        style=filled;
        color="'+colors[ic]+'";
        '+labels+'
        '+steps.join+'
        label = "'+stage.name+'";
        }'		

        ic+=1

      end	

      code='digraph G {
      splines=false;
      '+from_clients+'
      "clients" [style=filled,color="#FF7E51", label="'+clients.join+'"];
      '+to_products+'
      "products" [style=filled,color="#F9A366", label="'+products.join+'"];
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
    clients=clients_arr.enum_for(:each_with_index).collect do |x, j| 
      tab= j==clients_arr.count-1 ? "" :  '\n' 
      unless x.nil?
        y=x.name + tab
      end	

    end
    clients
  end  
  
  
  def get_products(operating_cycle)
    products_arr=operating_cycle.services	
    products=products_arr.enum_for(:each_with_index).collect do |x, k| 
      tab= k==products_arr.count-1 ? "" : '\n'
      unless x.nil?
        y=x.name + tab
      end	

    end
    products
  end  


end
