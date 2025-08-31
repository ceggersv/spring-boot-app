package com.example.demo.repository;

import com.example.demo.model.Usuario;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface UsuarioRepository extends MongoRepository<Usuario, String> {
    
    Optional<Usuario> findByEmail(String email);
    
    List<Usuario> findByNombreContainingIgnoreCase(String nombre);
    
    List<Usuario> findByApellidoContainingIgnoreCase(String apellido);
    
    List<Usuario> findByActivo(boolean activo);
    
    boolean existsByEmail(String email);
}
