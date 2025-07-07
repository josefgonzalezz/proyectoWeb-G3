/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package proyecto.com.domain;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.List;  
import lombok.Data;

/**
 * Entidad que representa una categoría de productos en la base de datos.
 * Mapeada a la tabla "categoria".
 * 
 * @author Andres
 */
@Data
@Entity
@Table(name="categoria")
public class Categoria implements Serializable {
    
    private static final long serialVersionUID = 1L;

    /**
     * Identificador único de la categoría.
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="id_categoria")
    private Long idCategoria;

    /**
     * Descripción de la categoría.
     */
    private String descripcion;

    /**
     * Ruta de la imagen asociada a la categoría.
     */
    private String rutaImagen;

    /**
     * Indica si la categoría está activa.
     */
    private boolean activo;

    /**
     * Lista de productos asociados a la categoría.
     */
    @OneToMany
    @JoinColumn(name = "id_categoria")
    private List<Producto> productos;

    /**
     * Constructor por defecto.
     */
    public Categoria() {
    }

    /**
     * Constructor que permite crear una categoría con descripción y estado.
     * 
     * @param categoria Descripción de la categoría.
     * @param activo Estado de la categoría (activa o no).
     */
    public Categoria(String categoria, boolean activo) {
        this.descripcion = categoria;
        this.activo = activo;
    }
}
