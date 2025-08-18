/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package proyecto.com.domain;

import jakarta.persistence.*;
import java.io.Serializable;
import lombok.Data;

/**
 * Entidad que representa un producto en la base de datos.
 * Mapeada a la tabla "producto".
 * 
 * @author Andres
 */
@Data
@Entity
@Table(name="producto")
public class Producto implements Serializable {
    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="id_producto")
    private Long idProducto;

    private String descripcion;
    private String talla;
    private String color;
    private double precio;
    private int existencias;
    private String rutaImagen;
    private boolean activo;

    @ManyToOne
    @JoinColumn(name="id_categoria")
    Categoria categoria;

    public Producto() {
    }

    public Producto(String descripcion, boolean activo) {
        this.descripcion = descripcion;
        this.activo = activo;
    }

  
    public Producto(Long idProducto) {
        this.idProducto = idProducto;
    }
}
