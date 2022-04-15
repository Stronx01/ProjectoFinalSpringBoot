package es.ifp.evento.dao;

import es.ifp.evento.beans.Usuario;
import es.ifp.evento.repository.UsuarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UsuarioDaoMySQL8 implements IntUsuarioMysql8JPA{
    @Autowired
    private UsuarioRepository urepo;
    @Override
    public Usuario findById(String username) {
        return urepo.findById(username).orElse(null);
    }

    @Override
    public Usuario findByIdPass(String username, String pass) {
        Usuario usu=urepo.findById(username).orElse(null);
        if(usu.getPassword().equals(pass)) return usu;
        else return null;
    }

    @Override
    public int altaUsuario(Usuario usuario) {
        int fila=0;
        try {
            urepo.save(usuario);
        }catch (Exception e){
            e.printStackTrace();
        }
        return fila=0;
    }
}
