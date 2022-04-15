package es.ifp.evento.repository;

import es.ifp.evento.beans.Evento;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface EventoRepository extends JpaRepository<Evento,Integer>{
    List<Evento>findByDestacadoAndEstado(String destacado,String estado);
    List<Evento>findByDestacado(String destacado);
    List<Evento>findByEstado(String estado);
    @Query("select e from Evento e where e.tipo.idTipo=?1")
    List<Evento>findByTipo(int idTipo);
}
