/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package proyecto.com.service;


import proyecto.com.domain.Constante;
import java.util.List;

public interface ConstanteService {
    
    //Se obtiene un listado de registro de la tabla constante
    //en un array list de objetos Constante
    //Todos o sólo los activos...
    public List<Constante> getConstantes();
    
    public Constante getConstante(Constante constante);
    
    public Constante getConstantePorAtributo(String atributo);
    
    public void save(Constante constante);
    
    public void delete(Constante constante);
}
