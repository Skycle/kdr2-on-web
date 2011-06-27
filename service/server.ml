(*
 * file : server.ml
 * author : KDr2
 *)

let cgi_handler (cgi:Netcgi.cgi) =
  let html = Route.route cgi () and
      out = cgi#out_channel#output_string in
  out html;
  cgi#out_channel#commit_work();
  cgi#finalize();;


let run_on_stdin () =
  let buffered _ ch = new Netchannels.buffered_trans_channel ch in
  Netcgi_fcgi.run
    ~output_type:(`Transactional buffered)
    (fun cgi -> cgi_handler(cgi :> Netcgi.cgi));;
    
let run_on_fd listen_fd =
  let fd,_ = Unix.accept listen_fd in while true do
      ignore(Netcgi_fcgi.handle_request
               Netcgi.default_config
               (`Direct "":Netcgi.output_type)
               (fun _ _ _ -> `Automatic)
               (fun _ f -> f())
               (fun cgi -> cgi_handler(cgi :> Netcgi.cgi))
               ~max_conns:5
               ~log:None
               fd);
    Unix.close(fd)
    done;;
  
let run_on_port port =
  let srvsock=Unix.socket Unix.PF_INET Unix.SOCK_STREAM 0 in
  let ()=Unix.bind srvsock (Unix.ADDR_INET(Unix.inet_addr_any,port)) and
      ()=Unix.listen srvsock 64 in
  run_on_fd srvsock;;

let run_on_fd_threaded ?(threads=5) listen_fd =
  let thread_fun () = while true do
      let fd,_ = Unix.accept listen_fd in
      ignore(Netcgi_fcgi.handle_request
               Netcgi.default_config
               (`Direct "":Netcgi.output_type)
               (fun _ _ _ -> `Automatic)
               (fun _ f -> f())
               (fun cgi -> cgi_handler(cgi :> Netcgi.cgi))
               ~max_conns:5
               ~log:None
               fd);
      Unix.close(fd)
    done
  and
      ths=ref []
  in
  for i = 1 to threads do
    ths := (Thread.create thread_fun ()):: !ths
  done;
  List.iter Thread.join !ths;;
  



let run_on_port_threaded ?(threads=5) port =
  let srvsock=Unix.socket Unix.PF_INET Unix.SOCK_STREAM 0 in
  let ()=Unix.bind srvsock (Unix.ADDR_INET(Unix.inet_addr_any,port)) and
      ()=Unix.listen srvsock 64 in
  run_on_fd_threaded ~threads:5 srvsock;;
