// function uvm_sequencer::new (string name, uvm_component parent=null);
//   super.new(name, parent);
//   //vvv %Error: t/t_uvm_pkg_todo.vh:19869:21: Function Argument expects a CLASSREFDTYPE 'uvm_sequencer__Tz97_TBz97', got CLASSREFDTYPE 'uvm_sequencer__Tz97'
//   seq_item_export = new ("seq_item_export", this);
// endfunction

class uvm_seq_item_pull_imp #(type REQ=int, type RSP=REQ, type IMP=int);
  local IMP m_imp;
  function new (string name, IMP imp);
  endfunction
  virtual function string get_type_name();
    return "uvm_seq_item_pull_imp";
  endfunction
endclass

class uvm_sequence_item;
endclass

class uvm_component;
endclass

class uvm_sequencer #(type REQ=uvm_sequence_item, RSP=REQ);
  typedef uvm_sequencer #(REQ, RSP) this_type;
  uvm_seq_item_pull_imp #(REQ, RSP, this_type) seq_item_export; ////////////////// 1
  extern function new (string name);
endclass

class uvm_sequencer__Tz1_TBz1;
  function new (string name);
  endfunction
endclass

function uvm_sequencer::new (string name);
  //super.new(name, parent);
//TODO issue #4497 - Fix uvm_sequencer wrong reference type
//TODO  %Error: t/t_uvm_pkg_todo.vh:19869:21: Function Argument expects a CLASSREFDTYPE 'uvm_sequencer__Tz97_TBz97', got CLASSREFDTYPE 'uvm_sequencer__Tz97'
//TODO  seq_item_export = new ("seq_item_export", this);
  seq_item_export = new ("seq_item_export", this); ////////////////// 2
endfunction

module t (
  input clk
);

  uvm_sequencer#(int) seqr;
  // uvm_sequencer seqr2;
endmodule : t