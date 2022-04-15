package es.ifp.evento.dao;


import es.ifp.evento.beans.Perfile;
import es.ifp.evento.repository.PrefileRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PerfilDaoMySQL8 implements IntPerfileMysql8JPA{
    @Autowired
    private PrefileRepository prepo;
    @Override
    public Perfile findById(int idPerfil) {
        return prepo.findById(idPerfil).orElse(null);
    }
}
