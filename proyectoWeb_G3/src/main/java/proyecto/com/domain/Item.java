/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package proyecto.com.domain;

import java.io.Serializable;
import lombok.Data;

@Data
public class Item implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    private Producto producto;
    private int cantidad;

    public Item(Producto producto) {
        this.producto = producto;
        this.cantidad = 1;
    }
    
  
    
    public Long getIdProducto() {
        return producto.getIdProducto();
    }
    
    public String getDescripcion() {
        return producto.getDescripcion();
    }
    
    public double getPrecio() {
        return producto.getPrecio();
    }
    
    public int getExistencias() {
        return producto.getExistencias();
    }
    
    public String getTalla() {
        return producto.getTalla();
    }
    
    public String getColor() {
        return producto.getColor();
    }
    
    public String getRutaImagen() {
        return producto.getRutaImagen();
    }
    
    public boolean isActivo() {
        return producto.isActivo();
    }
    
    // Total por ítem (precio * cantidad)
    public double getPrecioTotal() {
        return producto.getPrecio() * cantidad;
    }
}
