/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package proyecto.com.controller;

import proyecto.com.domain.Categoria;
import proyecto.com.domain.Producto;
import proyecto.com.service.CategoriaService;
import proyecto.com.service.ProductoService;
import proyecto.com.service.impl.FireBaseStorageServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping("/producto")
public class ProductoController {

    @Autowired
    private ProductoService productoService;

    @Autowired
    private CategoriaService categoriaService;

    @Autowired
    private FireBaseStorageServiceImpl firebaseStorageService;

    @GetMapping("/listado")
    private String listado(Model model) {
        var productos = productoService.getProductos(false);
        model.addAttribute("productos", productos);

        var categorias = categoriaService.getCategorias(false);
        model.addAttribute("categorias", categorias);

        model.addAttribute("totalProductos", productos.size());
        return "/producto/listado";
    }

    @GetMapping("/listado/{idCategoria}")
    public String listado(Model model, Categoria categoria) {
        var productos = categoriaService.getCategoria(categoria).getProductos();
        var categorias = categoriaService.getCategorias(false);
        model.addAttribute("productos", productos);
        model.addAttribute("totalProductos", productos.size());
        model.addAttribute("categorias", categorias);
        return "/producto/listado";
    }

    @GetMapping("/nuevo")
    public String productoNuevo(Producto producto) {
        return "/producto/modifica";
    }

   @PostMapping("/guardar")
public String productoGuardar(Producto producto,
        @RequestParam("imagenFile") MultipartFile imagenFile) {
    if (!imagenFile.isEmpty()) {
        productoService.save(producto); // primero guardar para obtener el ID
        producto.setRutaImagen(
            firebaseStorageService.cargarImagen(
                imagenFile,
                "producto",
                producto.getIdProducto())
        );
    }
    // Aquí ya contiene la ruta anterior si no se subió nueva imagen
    productoService.save(producto); // guardar definitivo
    return "redirect:/producto/listado";
}


    @GetMapping("/eliminar/{idProducto}")
    public String productoEliminar(Producto producto) {
        productoService.delete(producto);
        return "redirect:/producto/listado";
    }

    @GetMapping("/modificar/{idProducto}")
    public String productoModificar(Producto producto, Model model) {
        producto = productoService.getProducto(producto);
        model.addAttribute("producto", producto);

        var categorias = categoriaService.getCategorias(false);
        model.addAttribute("categorias", categorias);

        return "/producto/modifica";
    }
    @GetMapping("/ver/{idProducto}")
    public String productoVer(Producto producto, Model model) {
    producto = productoService.getProducto(producto);
    if (producto == null) {
        return "redirect:/producto/listado";
    }
    model.addAttribute("producto", producto);

    var categorias = categoriaService.getCategorias(false);
    model.addAttribute("categorias", categorias);

    return "/producto/ver";
    }
}