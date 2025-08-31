package com.example.demo.service;

import com.example.demo.model.Usuario;
import com.example.demo.repository.UsuarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class UsuarioService {
    
    @Autowired
    private UsuarioRepository usuarioRepository;
    
    public List<Usuario> getAllUsuarios() {
        return usuarioRepository.findAll();
    }
    
    public Optional<Usuario> getUsuarioById(String id) {
        return usuarioRepository.findById(id);
    }
    
    public Optional<Usuario> getUsuarioByEmail(String email) {
        return usuarioRepository.findByEmail(email);
    }
    
    public List<Usuario> getUsuariosByNombre(String nombre) {
        return usuarioRepository.findByNombreContainingIgnoreCase(nombre);
    }
    
    public List<Usuario> getUsuariosByApellido(String apellido) {
        return usuarioRepository.findByApellidoContainingIgnoreCase(apellido);
    }
    
    public List<Usuario> getUsuariosActivos() {
        return usuarioRepository.findByActivo(true);
    }
    
    public Usuario createUsuario(Usuario usuario) {
        if (usuarioRepository.existsByEmail(usuario.getEmail())) {
            throw new RuntimeException("Ya existe un usuario con ese email");
        }
        return usuarioRepository.save(usuario);
    }
    
    public Usuario updateUsuario(String id, Usuario usuario) {
        Optional<Usuario> existingUsuario = usuarioRepository.findById(id);
        if (existingUsuario.isPresent()) {
            Usuario updatedUsuario = existingUsuario.get();
            updatedUsuario.setNombre(usuario.getNombre());
            updatedUsuario.setApellido(usuario.getApellido());
            updatedUsuario.setEmail(usuario.getEmail());
            updatedUsuario.setTelefono(usuario.getTelefono());
            updatedUsuario.setDireccion(usuario.getDireccion());
            updatedUsuario.setActivo(usuario.isActivo());
            return usuarioRepository.save(updatedUsuario);
        }
        throw new RuntimeException("Usuario no encontrado con id: " + id);
    }
    
    public void deleteUsuario(String id) {
        if (usuarioRepository.existsById(id)) {
            usuarioRepository.deleteById(id);
        } else {
            throw new RuntimeException("Usuario no encontrado con id: " + id);
        }
    }
    
    public void deactivateUsuario(String id) {
        Optional<Usuario> usuario = usuarioRepository.findById(id);
        if (usuario.isPresent()) {
            Usuario updatedUsuario = usuario.get();
            updatedUsuario.setActivo(false);
            usuarioRepository.save(updatedUsuario);
        } else {
            throw new RuntimeException("Usuario no encontrado con id: " + id);
        }
    }
}
