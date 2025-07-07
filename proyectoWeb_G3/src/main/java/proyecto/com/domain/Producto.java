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
    
    /**
     * Identificador único del producto.
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="id_producto")
    private Long idProducto;

    /**
     * Descripción del producto.
     */
    private String descripcion;

    /**
     * Talla del producto.
     */
    private String talla;

    /**
     * Color del producto.
     */
    private String color;

    /**
     * Precio del producto.
     */
    private double precio;

    /**
     * Existencias disponibles del producto.
     */
    private int existencias;

    /**
     * Ruta de la imagen asociada al producto.
     */
    private String rutaImagen;

    /**
     * Indica si el producto está activo.
     */
    private boolean activo;

    /**
     * Categoría a la que pertenece el producto.
     */
    @ManyToOne
    @JoinColumn(name="id_categoria")
    Categoria categoria;

    /**
     * Constructor por defecto.
     */
    public Producto() {
    }

    /**
     * Constructor que permite crear un producto con descripción y estado.
     * 
     * @param descripcion Descripción del producto.
     * @param activo Estado del producto (activo o no).
     */
    public Producto(String descripcion, boolean activo) {
        this.descripcion = descripcion;
        this.activo = activo;
    }
    
}
