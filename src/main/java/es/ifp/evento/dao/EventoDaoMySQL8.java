package es.ifp.evento.dao;

import es.ifp.evento.beans.Evento;
import es.ifp.evento.repository.EventoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EventoDaoMySQL8 implements IntEventoMysql8JPA{
    @Autowired
    private EventoRepository erepo;

    @Override
    public List<Evento> findByDestacadoAndEstado(String destacado, String estado) {
        return erepo.findByDestacadoAndEstado(destacado,estado);
    }

    @Override
    public List<Evento> findByDestacado(String destacado) {
        return erepo.findByDestacado(destacado);
    }

    @Override
    public List<Evento> findByEstado(String estado) {
        return erepo.findByEstado(estado);
    }

    @Override
    public List<Evento> findByTipo(int idTipo) {
        return erepo.findByTipo(idTipo);
    }

    @Override
    public Evento findById(int idEvento) {
        return erepo.findById(idEvento).orElse(null);
    }

    @Override
    public int modificarEvento(Evento evento) {
        int fila=0;
        try {
            erepo.save(evento);
            fila=1;
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return fila;
    }
}
