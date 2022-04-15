package es.ifp.evento.dao;

import es.ifp.evento.beans.Tipo;
import es.ifp.evento.repository.TipoRepsitory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class TipoDaoMySQL8 implements IntTipoMysql8JPA{
    @Autowired
    private TipoRepsitory trepo;

    @Override
    public List<Tipo> findAll() {
        return trepo.findAll();
    }

    @Override
    public Tipo findById(int idTipo) {
        return trepo.findById(idTipo).orElse(null);
    }
}
