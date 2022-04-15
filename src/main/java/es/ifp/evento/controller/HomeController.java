package es.ifp.evento.controller;

import es.ifp.evento.beans.*;
import es.ifp.evento.dao.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.net.http.HttpClient;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
public class HomeController {
    @Autowired
    private EventoDaoMySQL8 edao;
    @Autowired
    private TipoDaoMySQL8 tdao;
    @Autowired
    private UsuarioDaoMySQL8 udao;
    @Autowired
    private PerfilDaoMySQL8 pdao;
    @Autowired
    private ReservaDaoMySQL8 rdao;
    @GetMapping("/")
    public String inicio(Authentication aut,Model model, RedirectAttributes rd, HttpSession session){
        if(aut!=null){
            Usuario usu=udao.findById(aut.getName());
            session.setAttribute("usuario", usu);
            model.addAttribute("usuNombre", usu.getNombre());
        }
        List<Tipo>listaTipo=tdao.findAll();
        List<Evento>listaEvento=edao.findByDestacadoAndEstado("S","Activo");
        model.addAttribute("listTipo",listaTipo);
        model.addAttribute("liEventos",listaEvento);
        model.addAttribute("evento","destacados");
        return "index";
    }
    @GetMapping("/index")
    public String procIndex(Authentication aut,Model model, RedirectAttributes rd, HttpSession session){
        if(aut!=null){
            Usuario usu=udao.findById(aut.getName());
            session.setAttribute("usuario", usu);
            model.addAttribute("usuNombre", usu.getNombre());
        }
        List<Tipo>listaTipo=tdao.findAll();
        List<Evento>listaEvento=edao.findByDestacadoAndEstado("S","activo");
        model.addAttribute("listTipo",listaTipo);
        model.addAttribute("liEventos",listaEvento);
        model.addAttribute("evento","destacados");
        return "index";
    }
    @GetMapping("/registro")
    public  String progRegistar(){
        return "registro";
    }
    @GetMapping("/destacado")
    public String listDestacado(Model model, RedirectAttributes rd, HttpSession session){
        List<Tipo>listaTipo=tdao.findAll();
        List<Evento>listaEvento=edao.findByDestacado("S");
        model.addAttribute("listTipo",listaTipo);
        model.addAttribute("liEventos",listaEvento);
        model.addAttribute("evento", "destacados");
        return "index";
    }
    @GetMapping("/estado")
    public String listActivos(Model model, RedirectAttributes rd, HttpSession session){
        List<Tipo>listaTipo=tdao.findAll();
        List<Evento>listaEvento=edao.findByEstado("activo");
        model.addAttribute("listTipo",listaTipo);
        model.addAttribute("liEventos",listaEvento);
        model.addAttribute("evento", "activos");
        return "index";
    }
    @GetMapping("/tipo/{idTipo}")
    public String listTipos(Model model, RedirectAttributes rd, HttpSession session, @PathVariable int idTipo){
        List<Tipo>listaTipo=tdao.findAll();
        List<Evento>listaEvento=edao.findByTipo(idTipo);
        model.addAttribute("listTipo",listaTipo);
        model.addAttribute("liEventos",listaEvento);
        model.addAttribute("evento", "activos");
        return "index";
    }
    @GetMapping("/cliente/miReserva")
    public String procMiReserva(HttpSession session, Model model){
        List<Tipo>listaTipo=tdao.findAll();
        Usuario usu=(Usuario)session.getAttribute("usuario");
        model.addAttribute("listTipo",listaTipo);
        List<Reserva>reserva=rdao.findPorUsername(usu.getUsername());
        model.addAttribute("liReserv",reserva);
        return "miReserva";
    }
    @PostMapping("/registro/usuario")
    public String procRegistro(@RequestParam("username")String username,@RequestParam("password")String password
            ,@RequestParam("nombre")String nombre,@RequestParam("apellidos")String apelldios,
                               @RequestParam("direccion")String direccion,RedirectAttributes rd){
        Usuario usu=new Usuario();
        Perfile per=pdao.findById(3);
        List<Perfile>perList=new ArrayList<>();
        perList.add(per);
        usu.setUsername(username);
        usu.setPassword("{noop}"+password);
        usu.setNombre(nombre);
        usu.setApellidos(apelldios);
        usu.setFechaRegistro(new Date());
        usu.setPerfiles(perList);
        usu.setEnabled(1);
        usu.setDireccion(direccion);
        udao.altaUsuario(usu);
        return "redirect:/index";
    }
    @PostMapping("/cliente/reserva/{idEvento}")
    public String procReserva(@RequestParam("cantidad") int cantidad,RedirectAttributes rd,
                              @PathVariable int idEvento, HttpSession session) {
        Evento eve=edao.findById(idEvento);
        Reserva res=new Reserva();
        Usuario usu=(Usuario)session.getAttribute("usuario");
        if(cantidad>10){
            rd.addFlashAttribute("mensaje","Introduce menos de 10 plazas");
        }
        else if (cantidad>eve.getAforoMaximo()){
            rd.addFlashAttribute("mensaje","La cantidad introducida supera al aforo Maximo");
        }
        else if(rdao.findByEventoAndUsuario(eve, usu)==null){
                int NuevoAforo=eve.getAforoMaximo()-cantidad;
                eve.setAforoMaximo(NuevoAforo);
                edao.modificarEvento(eve);
                res.setCantidad(cantidad);
                res.setUsuario((Usuario)session.getAttribute("usuario"));
                res.setEvento(eve);
                res.setPrecioVenta(BigDecimal.valueOf(cantidad*eve.getPrecio().intValue()));
                res.setObservaciones(eve.getDescripcion());
                rdao.altaResrva(res);
                rd.addFlashAttribute("mensaje","Reserva completada");
            }
            else {
                rd.addFlashAttribute("mensaje","Evento ya reservado");
            }
        return "redirect:/index";
    }
    @GetMapping("/cliente/reserva/cancelar/{idReserva}")
    public String deleteReseva(@PathVariable int idReserva,Model model,RedirectAttributes rd){
        Evento eve=rdao.findById(idReserva).getEvento();
        int cantidad=rdao.findById(idReserva).getCantidad()+eve.getAforoMaximo();
        eve.setAforoMaximo(cantidad);
        edao.modificarEvento(eve);
        if(rdao.deleteReserva(idReserva)==1){
            rd.addFlashAttribute("mensaje", "Reserva eliminada");
        }
        else {
            rd.addFlashAttribute("mensaje","Reserva no eliminada");
        }
        return "redirect:/cliente/miReserva";
    }
}
