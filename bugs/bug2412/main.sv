class uvm_object;
endclass

class uvm_callbacks_base extends uvm_object;
endclass

class uvm_agent extends uvm_object;
endclass

class uvm_env extends uvm_object;
endclass

class uvm_typed_callbacks#(type T=uvm_object) extends uvm_callbacks_base;
  typedef uvm_typed_callbacks#(T) this_type;

  virtual function bit m_am_i_a(uvm_object obj);
    T this_type;
    if (obj == null)
      return 1;
    return ($cast(this_type, obj));
  endfunction

  function void test();
  endfunction : test
    
endclass


module t;

  uvm_agent agent = new;
  uvm_env env = new;
  uvm_typed_callbacks#(uvm_agent) agent_callback = new;
  uvm_typed_callbacks#(uvm_env) env_callback = new;

  initial begin
    $display("v0 = %0d", agent_callback.m_am_i_a(null));
    $display("v1 = %0d", agent_callback.m_am_i_a(agent));
    $display("v2 = %0d", agent_callback.m_am_i_a(env));
    $display("v3 = %0d", env_callback.m_am_i_a(agent));
    $display("v4 = %0d", env_callback.m_am_i_a(env));
    $display("v5 = %0d", agent_callback.m_am_i_a(agent_callback));
    $display("v6 = %0d", agent_callback.m_am_i_a(env_callback));
    $finish;
    // # v0 = 1
    // # v1 = 0
    // # v2 = 0
    // # v3 = 1
    // # v4 = 0
    // # v5 = 0
  end
endmodule : t